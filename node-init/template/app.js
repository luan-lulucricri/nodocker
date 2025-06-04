import morgan from "morgan";
import cors from "cors";
import helmet from "helmet";
import fs from "fs";
import path from "path";
import { createStream } from "rotating-file-stream";
import express from "express";

const app = express();

// Cria o diretório logs se não existir
const logDir = path.join(process.cwd(), "logs");
if (!fs.existsSync(logDir)) {
    fs.mkdirSync(logDir);
}

const accessLogStream = createStream("access.log", {
    size: "10M",
    interval: "2d",
    path: logDir,
    compress: "gzip",
    maxFiles: 30,
});

morgan.token("real-ip", req => req.headers["x-forwarded-for"] || req.socket.remoteAddress);
const detailedFormat = ':date[iso] :real-ip :method :url :status :res[content-length] - :response-time ms ":referrer" ":user-agent"';

app.use(morgan(detailedFormat, { stream: accessLogStream }));
app.use(morgan("dev"));

app.use(cors());
app.use(helmet());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Rotas da API
app.get("/api", (req, res) => {
    res.json({
        message: "🚀 API RESTful ativa com sucesso!",
        status: "ok"
    });
});

// 404 handler (API-style)
app.use((req, res) => {
    res.status(404).json({
        error: true,
        message: "Rota não encontrada",
        path: req.originalUrl
    });
});

// Error handler (API-style)
app.use((err, req, res, next) => {
    console.error("Error:", err.message);
    res.status(err.status || 500).json({
        error: true,
        message: err.message || "Erro interno no servidor"
    });
});

export default app;
