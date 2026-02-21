import express from 'express';
import multer from 'multer';
import { createBullBoard } from '@bull-board/api';
import { BullMQAdapter } from '@bull-board/api/bullMQAdapter';
import { ExpressAdapter } from '@bull-board/express';
import { videoQueue } from './queue';

const app = express();
const port = 3000;

app.use(express.json());

// Configure multer for file uploads
const upload = multer({ dest: 'uploads/' });

// Routes
app.post('/upload', upload.array('files'), (req, res) => {
  // Handle file upload
  res.send('Files uploaded');
});

app.post('/render', (req, res) => {
  // Add job to queue
  videoQueue.add('render', req.body);
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
const serverAdapter = new ExpressAdapter();
serverAdapter.setBasePath('/admin/queues');
createBullBoard({
  queues: [new BullMQAdapter(videoQueue)],
  serverAdapter,
});
app.use('/admin/queues', serverAdapter.getRouter());

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});