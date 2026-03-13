import express, { Request, Response } from 'express';
import bodyParser from 'body-parser'; //für POST requests
import 'dotenv/config';
import fs from 'fs';
import path from 'path';
import { title } from 'process';
import sqlite3 from 'sqlite3';
import { Food } from './models/food';

const app = express();
app.use(bodyParser.json());
app.use('/images', express.static(path.join(process.cwd(), 'dist/images')));
app.use((req: Request, res: Response, next) => {
  console.log(req.url);
  next();
});

const middleWareGet = (req: Request, res: Response, next: Function) => {
  console.log(`this is the middle ware for GET`);
  next();
};

const port = process.env.PORT || 3000;

const db = new sqlite3.Database('foods.sqlite');

function loadData(): void {
  if (fs.existsSync('foods.sqlite')) return;
  db.serialize(() => {
    //für jede Tabelle ein db.run()
    db.run('CREATE TABLE IF NOT EXISTS food (id INTEGER PRIMARY KEY, name TEXT, description TEXT, shopname TEXT, price REAL, unit TEXT, image TEXT)');
    db.run('CREATE TABLE IF NOT EXISTS orders (id INTEGER PRIMARY KEY, name TEXT)');
    db.run('CREATE TABLE IF NOT EXISTS order_items (id INTEGER, food_id INTEGER, order_id INTEGER, quantity INTEGER NOT NULL DEFAULT 1, PRIMARY KEY (order_id, food_id), FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE, FOREIGN KEY (food_id) REFERENCES foods(id))');

    fs.readFile(path.join(process.cwd(), 'dist/csv', 'foods.csv'), 'utf-8', (_, data) => {
      const lines = data.split('\n');
      lines.shift();
      lines.forEach(line => {
        //id,name,description,shopname,price,unit
        if (line) {
          const parts = line.split(',');
          db.run('INSERT INTO food (name, description, shopname, price, unit, image) VALUES ($name, $description, $shopname, $price, $unit, $image)', {
            $name: parts[1],
            $description: parts[2],
            $shopname: parts[3],
            $price: parts[4],
            $unit: parts[5],
            $image: parts[6]
          });
        }
      });
    });
  });
}

loadData();

// Migration: ensure image column exists and is populated
db.serialize(() => {
  db.run('ALTER TABLE food ADD COLUMN image TEXT', (err) => {
    // Falls Spalte schon da ist, Fehler ignorieren
    
    // Daten befüllen falls sie leer sind
    fs.readFile(path.join(process.cwd(), 'dist/csv', 'foods.csv'), 'utf-8', (_, data) => {
      const lines = data.split('\n');
      lines.shift(); // Header weg
      lines.forEach(line => {
        if (line) {
          const parts = line.split(',');
          // parts: id(0), name(1), description(2), shopname(3), price(4), unit(5), image(6)
          db.run('UPDATE food SET image = $image WHERE name = $name AND (image IS NULL OR image = "")', {
            $name: parts[1],
            $image: parts[6]
          });
        }
      });
    });
  });
});

app.get('/foods', middleWareGet, (req: Request, res: Response) => {
  db.all('SELECT id, name, description, shopname, price, unit, image FROM food', (err, foods: Food[]) => {
    res.send(foods);
  });
});

app.get('/foods{/:searchString}', middleWareGet, (req: Request, res: Response) => {
  db.all('SELECT id, name, description, shopname, price, unit, image FROM food', (err, foods: Food[]) => {
    res.send(foods.find(x => x.name.includes(req.params.searchString)));
  });
});


app.listen(port, () => {
  console.log(`server started on port ${port}`);
});


