// Array to store tasks
let tasks = [];

/*
 Function: addTask
 Purpose: Adds a new task to the task list
*/
function addTask() {
    const input = document.getElementById("taskInput");
    const taskText = input.value.trim();

    if (taskText === "") {
        alert("Please enter a task.");
        return;
    }

    // Create task object
    const task = {
        id: Date.now(),
        text: taskText,
        completed: false
    };

    tasks.push(task);
    input.value = "";

    renderTasks();
}

/*
 Function: toggleTask
 Purpose: Marks a task as completed or not
*/
function toggleTask(id) {
    tasks = tasks.map(task => {
        if (task.id === id) {
            task.completed = !task.completed;
        }
        return task;
    });

    renderTasks();
}

/*
 Function: deleteTask
 Purpose: Removes a task from the list
*/
function deleteTask(id) {
    tasks = tasks.filter(task => task.id !== id);
    renderTasks();
}

/*
 Function: renderTasks
 Purpose: Updates the UI with current tasks
*/
function renderTasks() {
    const taskList = document.getElementById("taskList");
    const stats = document.getElementById("stats");

    taskList.innerHTML = "";

    tasks.forEach(task => {
        const li = document.createElement("li");

        const span = document.createElement("span");
        span.textContent = task.text;

        if (task.completed) {
            span.classList.add("completed");
        }

        span.onclick = () => toggleTask(task.id);

        const deleteBtn = document.createElement("button");
        deleteBtn.textContent = "X";
        deleteBtn.onclick = () => deleteTask(task.id);

        li.appendChild(span);
        li.appendChild(deleteBtn);
        taskList.appendChild(li);
    });

    updateStats();
}

/*
 Function: updateStats
 Purpose: Updates completed task counter
*/
function updateStats() {
    const stats = document.getElementById("stats");
    const completed = tasks.filter(task => task.completed).length;
    stats.textContent = `Completed: ${completed} / ${tasks.length}`;
}
