import express, { Request, Response } from 'express';
import bodyParser from 'body-parser'; //für POST requests
import 'dotenv/config';
import fs from 'fs';
import path from 'path';
import { title } from 'process';
import { Book } from './models/food';
import sqlite3 from 'sqlite3';

const app = express();
app.use(bodyParser.json());
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

const books: Book[] = [];

function loadData(): void {
  if (fs.existsSync('foods.sqlite')) return;
  db.serialize(() => {
    //für jede Tabelle ein db.run()
    db.run('CREATE TABLE IF NOT EXISTS food (id INTEGER PRIMARY KEY, name TEXT, description TEXT, shopname TEXT, price REAL, unit TEXT)');
    db.run('CREATE TABLE IF NOT EXISTS orders (id INTEGER PRIMARY KEY, name TEXT)');
    db.run('CREATE TABLE IF NOT EXISTS order_items (order_id INTEGER, food_id INTEGER, quantity INTEGER NOT NULL DEFAULT 1, PRIMARY KEY (order_id, food_id), FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE, FOREIGN KEY (food_id) REFERENCES foods(food_id))');
  });
}

loadData();

app.get('/books', middleWareGet, (req: Request, res: Response) => {
  db.all('SELECT id, title, author, year FROM book', (err, books: Book[]) => {
    res.send(books);
  });

});

app.get('/books{/:id}', middleWareGet, (req: Request, res: Response) => {
  db.all('SELECT id, title, author, year FROM book', (err, books: Book[]) => {
    res.send(books.find(x => x.id === (+req.params.id)));
  })
});

app.post('/books', (req: Request, res: Response) => {
  const book: Book = req.body;
  db.run('INSERT INTO book (title, author, year) VALUES ($title, $author, $year)', {
    // $title: book.title,
    // $author: book.author,
    // $year: book.year
  });
  res.status(200).send();
});

app.put('/books{/:id}', (req: Request, res: Response) => {
  const book: Book = req.body;
  db.run('UPDATE book SET title = $title, author = $author, year = $year WHERE id = $id', {
    // $id: req.params.id,
    // $title: book.title,
    // $author: book.author,
    // $year: book.year
  });
  res.status(200).send();
});

app.delete('/books{/:id}', (req: Request, res: Response) => {
  db.run('DELETE FROM book WHERE id = $id', {
    $id: req.params.id,
  });
  res.status(200).send();
});

app.listen(port, () => {
  console.log(`server started on port ${port}`);
});


