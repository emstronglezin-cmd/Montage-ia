"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.VideoController = void 0;
const fluent_ffmpeg_1 = __importDefault(require("fluent-ffmpeg"));
const path_1 = __importDefault(require("path"));
class VideoController {
    static async renderVideo(script, files) {
        // Simple implementation: concatenate videos
        const outputPath = path_1.default.join(__dirname, '../../outputs', `output_${Date.now()}.mp4`);
        return new Promise((resolve, reject) => {
            const command = (0, fluent_ffmpeg_1.default)();
            files.forEach(file => {
                command.input(file);
            });
            command
                .on('end', () => resolve(outputPath))
                .on('error', reject)
                .mergeToFile(outputPath, __dirname);
        });
    }
    static parseScript(script) {
        // Simple parser
        return script.split('->').map(p => p.trim());
    }
}
exports.VideoController = VideoController;
