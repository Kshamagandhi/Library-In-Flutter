const express = require('express');
//const request = require('request');
const cors = require('cors');

const app = express();
app.use(cors());

app.get('/api/volumes/brief/isbn/:isbn', (req, res) => {
    const isbn = req.params.isbn;
    // Mock data for testing
    const mockData = {
        "9780525440987": {
            title: "The Catcher in the Rye",
            author: "J.D. Salinger",
            year: 1951,
        },
    };

    if (mockData[isbn]) {
        res.json(mockData[isbn]);
    } else {
        res.status(404).json({ error: "notfound", key: `/volumes/brief/isbn/${isbn}` });
    }
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
