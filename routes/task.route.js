const express = require("express");
const router = express.Router();
const task = require("../controllers/task.controller");

//creating task and getting all tasks
router.route("/").get(task.getAllTasks).post(task.createTask);

//getting a single task and editing and deleting it

router
  .route("/:id")
  .get(task.getSingleTask)
  .put(task.editTask)
  .delete(task.deleteTask);

module.exports = router;
