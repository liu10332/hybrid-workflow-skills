// 待办事项应用
class TodoApp {
    constructor() {
        this.todos = JSON.parse(localStorage.getItem('todos')) || [];
        this.currentFilter = 'all';
        
        this.init();
    }
    
    init() {
        // 获取DOM元素
        this.todoInput = document.getElementById('todoInput');
        this.addBtn = document.getElementById('addBtn');
        this.todoList = document.getElementById('todoList');
        this.itemCount = document.getElementById('itemCount');
        this.clearCompleted = document.getElementById('clearCompleted');
        this.filterBtns = document.querySelectorAll('.filter-btn');
        
        // 绑定事件
        this.bindEvents();
        
        // 渲染列表
        this.render();
    }
    
    bindEvents() {
        // 添加待办事项
        this.addBtn.addEventListener('click', () => this.addTodo());
        this.todoInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                this.addTodo();
            }
        });
        
        // 清除已完成
        this.clearCompleted.addEventListener('click', () => this.clearCompletedTodos());
        
        // 过滤按钮
        this.filterBtns.forEach(btn => {
            btn.addEventListener('click', (e) => {
                this.setFilter(e.target.dataset.filter);
            });
        });
    }
    
    addTodo() {
        const text = this.todoInput.value.trim();
        
        if (text) {
            const todo = {
                id: Date.now(),
                text: text,
                completed: false,
                createdAt: new Date().toISOString()
            };
            
            this.todos.push(todo);
            this.save();
            this.render();
            
            this.todoInput.value = '';
            this.todoInput.focus();
        }
    }
    
    toggleTodo(id) {
        const todo = this.todos.find(t => t.id === id);
        
        if (todo) {
            todo.completed = !todo.completed;
            this.save();
            this.render();
        }
    }
    
    deleteTodo(id) {
        this.todos = this.todos.filter(t => t.id !== id);
        this.save();
        this.render();
    }
    
    clearCompletedTodos() {
        this.todos = this.todos.filter(t => !t.completed);
        this.save();
        this.render();
    }
    
    setFilter(filter) {
        this.currentFilter = filter;
        
        // 更新按钮状态
        this.filterBtns.forEach(btn => {
            btn.classList.toggle('active', btn.dataset.filter === filter);
        });
        
        this.render();
    }
    
    getFilteredTodos() {
        switch (this.currentFilter) {
            case 'active':
                return this.todos.filter(t => !t.completed);
            case 'completed':
                return this.todos.filter(t => t.completed);
            default:
                return this.todos;
        }
    }
    
    save() {
        localStorage.setItem('todos', JSON.stringify(this.todos));
    }
    
    render() {
        const filteredTodos = this.getFilteredTodos();
        
        // 清空列表
        this.todoList.innerHTML = '';
        
        // 添加待办事项
        filteredTodos.forEach(todo => {
            const li = document.createElement('li');
            li.className = `todo-item ${todo.completed ? 'completed' : ''}`;
            
            li.innerHTML = `
                <input type="checkbox" class="checkbox" ${todo.completed ? 'checked' : ''}>
                <span class="todo-text">${this.escapeHtml(todo.text)}</span>
                <button class="delete-btn">删除</button>
            `;
            
            // 绑定事件
            const checkbox = li.querySelector('.checkbox');
            checkbox.addEventListener('change', () => this.toggleTodo(todo.id));
            
            const deleteBtn = li.querySelector('.delete-btn');
            deleteBtn.addEventListener('click', () => this.deleteTodo(todo.id));
            
            this.todoList.appendChild(li);
        });
        
        // 更新计数
        this.updateCount();
    }
    
    updateCount() {
        const activeTodos = this.todos.filter(t => !t.completed);
        this.itemCount.textContent = `${activeTodos.length} 个项目`;
    }
    
    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}

// 初始化应用
document.addEventListener('DOMContentLoaded', () => {
    new TodoApp();
});