function addTodo() {
    const input = document.getElementById('todo-input');
    const list = document.getElementById('todo-list');
    const todoText = input.value.trim();

    if (todoText !== '') {
        const li = document.createElement('li');
        li.innerHTML = `
            ${todoText}
            <button class="delete-btn" onclick="deleteTodo(this)">Delete</button>
        `;
        list.appendChild(li);
        input.value = '';
    }
}

function deleteTodo(button) {
    const li = button.parentElement;
    li.remove();
}