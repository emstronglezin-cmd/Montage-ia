"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const multer_1 = __importDefault(require("multer"));
const api_1 = require("@bull-board/api");
const bullMQAdapter_1 = require("@bull-board/api/bullMQAdapter");
const express_2 = require("@bull-board/express");
const queue_1 = require("./queue");
const app = (0, express_1.default)();
const port = 3000;
app.use(express_1.default.json());
// Configure multer for file uploads
const upload = (0, multer_1.default)({ dest: 'uploads/' });
// Routes
app.post('/upload', upload.array('files'), (req, res) => {
    // Handle file upload
    res.send('Files uploaded');
});
app.post('/render', (req, res) => {
    // Add job to queue
    queue_1.videoQueue.add('render', req.body);
    res.send('Render job added');
});
app.get('/status/:jobId', (req, res) => {
    // Get job status
});
app.get('/download/:videoId', (req, res) => {
    // Download video
});
app.get('/user/quota', (req, res) => {
    // Get user quota
});
// Bull Board for monitoring
const serverAdapter = new express_2.ExpressAdapter();
serverAdapter.setBasePath('/admin/queues');
(0, api_1.createBullBoard)({
    queues: [new bullMQAdapter_1.BullMQAdapter(queue_1.videoQueue)],
    serverAdapter,
});
app.use('/admin/queues', serverAdapter.getRouter());
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
