const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const TaskSchema = new Schema(
  {
    title: String,
    isCompleted: Boolean,
    startTime: {
      type: Date,
    },
    endTime: {
      type: Date,
    },
    repeated: String,
  },
  { timestamps: true }
);

module.exports = mongoose.model("Task", TaskSchema);
