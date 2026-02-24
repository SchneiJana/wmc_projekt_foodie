"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.BooksService = void 0;
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
class BooksService {
    constructor() {
        this.csvFilename = 'csv/books.csv';
        this._books = [];
        this.readBooksFromCsvFile();
    }
    readBooksFromCsvFile() {
        fs_1.default.readFile(path_1.default.join(process.cwd(), "dist", this.csvFilename), 'utf-8', (_, data) => {
            const entries = data.split('\n');
            entries.shift();
            entries.forEach(line => {
                if (line) {
                    const parts = line.split(',');
                    const book = { id: +parts[0], title: parts[1], author: parts[2], year: +parts[3] };
                    this._books.push(book);
                }
            });
        });
    }
    getAllBooks() {
        return this._books.sort((a, b) => a.title.localeCompare(b.title));
    }
    getBookById(id) {
        return this._books.find(x => x.id === id);
    }
}
exports.BooksService = BooksService;
