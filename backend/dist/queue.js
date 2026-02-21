"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.videoQueue = void 0;
const bullmq_1 = require("bullmq");
const videoController_1 = require("./controllers/videoController");
exports.videoQueue = new bullmq_1.Queue('video-render', {
    connection: {
        host: 'localhost',
        port: 6379,
    },
});
// Worker to process jobs
const worker = new bullmq_1.Worker('video-render', async (job) => {
    const { script, files } = job.data;
    const outputPath = await videoController_1.VideoController.renderVideo(script, files);
    return outputPath;
}, {
    connection: {
        host: 'localhost',
        port: 6379,
    },
});
