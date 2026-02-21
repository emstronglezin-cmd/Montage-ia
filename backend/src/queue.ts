import { Queue, Worker } from 'bullmq';
import { VideoController } from './controllers/videoController';

export const videoQueue = new Queue('video-render', {
  connection: {
    host: 'localhost',
    port: 6379,
  },
});

// Worker to process jobs
const worker = new Worker('video-render', async (job) => {
  const { script, files } = job.data;
  const outputPath = await VideoController.renderVideo(script, files);
  return outputPath;
}, {
  connection: {
    host: 'localhost',
    port: 6379,
  },
});