import 'dotenv/config';
import fs from 'fs';
import https from 'https';
import app from './app.js';


const PORT = process.env.PORT || 3000;

const httpsOptions = {
    key: fs.readFileSync('certs/server.key'),
    cert: fs.readFileSync('certs/server.cert'),
};

https.createServer(httpsOptions, app).listen(PORT, () => {
    console.log(`[Server]: 🚀 Servidor rodando em https://localhost:${PORT}`);
});
