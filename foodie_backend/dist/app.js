"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
require("dotenv/config");
const books_service_1 = require("./services/books-service");
const booksService = new books_service_1.BooksService();
const app = (0, express_1.default)();
const port = process.env.PORT || 3000;
app.get('/books{/:id}', (req, res) => {
    if (!req.params.id) {
        res.send(booksService.getAllBooks());
    }
    const book = booksService.getBookById(+req.params.id);
    if (!book) {
        res.status(404);
    }
    res.send(book);
});
app.listen(port, () => {
    console.log(`server started on port ${port}`);
});
