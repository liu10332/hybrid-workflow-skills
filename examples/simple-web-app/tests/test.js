// 简单的测试框架
class TestRunner {
    constructor() {
        this.tests = [];
        this.passed = 0;
        this.failed = 0;
    }
    
    test(name, fn) {
        this.tests.push({ name, fn });
    }
    
    run() {
        console.log('开始运行测试...\n');
        
        this.tests.forEach(({ name, fn }) => {
            try {
                fn();
                console.log(`✓ ${name}`);
                this.passed++;
            } catch (error) {
                console.error(`✗ ${name}`);
                console.error(`  错误: ${error.message}\n`);
                this.failed++;
            }
        });
        
        console.log('\n测试结果:');
        console.log(`  通过: ${this.passed}`);
        console.log(`  失败: ${this.failed}`);
        console.log(`  总计: ${this.tests.length}`);
        
        return this.failed === 0;
    }
}

// 断言函数
function assert(condition, message) {
    if (!condition) {
        throw new Error(message || '断言失败');
    }
}

function assertEqual(actual, expected, message) {
    if (actual !== expected) {
        throw new Error(message || `期望 ${expected}，实际得到 ${actual}`);
    }
}

// 创建测试运行器
const runner = new TestRunner();

// 测试用例
runner.test('应该能够创建待办事项', () => {
    const app = new TodoApp();
    const initialCount = app.todos.length;
    
    app.todoInput.value = '测试待办事项';
    app.addTodo();
    
    assertEqual(app.todos.length, initialCount + 1, '待办事项数量应该增加');
    assertEqual(app.todos[app.todos.length - 1].text, '测试待办事项', '待办事项文本应该匹配');
});

runner.test('应该能够标记待办事项为完成', () => {
    const app = new TodoApp();
    
    // 添加一个待办事项
    app.todoInput.value = '待完成的事项';
    app.addTodo();
    
    const todoId = app.todos[app.todos.length - 1].id;
    assert(!app.todos[app.todos.length - 1].completed, '新待办事项应该未完成');
    
    // 标记为完成
    app.toggleTodo(todoId);
    assert(app.todos[app.todos.length - 1].completed, '待办事项应该标记为完成');
});

runner.test('应该能够删除待办事项', () => {
    const app = new TodoApp();
    
    // 添加一个待办事项
    app.todoInput.value = '待删除的事项';
    app.addTodo();
    
    const todoId = app.todos[app.todos.length - 1].id;
    const initialCount = app.todos.length;
    
    // 删除待办事项
    app.deleteTodo(todoId);
    assertEqual(app.todos.length, initialCount - 1, '待办事项数量应该减少');
});

runner.test('应该能够清除已完成的待办事项', () => {
    const app = new TodoApp();
    
    // 添加两个待办事项
    app.todoInput.value = '未完成的事项';
    app.addTodo();
    
    app.todoInput.value = '已完成的事项';
    app.addTodo();
    
    // 标记第二个为完成
    const todoId = app.todos[app.todos.length - 1].id;
    app.toggleTodo(todoId);
    
    const initialCount = app.todos.length;
    
    // 清除已完成
    app.clearCompletedTodos();
    assertEqual(app.todos.length, initialCount - 1, '应该清除一个已完成的待办事项');
});

runner.test('应该能够过滤待办事项', () => {
    const app = new TodoApp();
    
    // 添加两个待办事项
    app.todoInput.value = '未完成的事项';
    app.addTodo();
    
    app.todoInput.value = '已完成的事项';
    app.addTodo();
    
    // 标记第二个为完成
    const todoId = app.todos[app.todos.length - 1].id;
    app.toggleTodo(todoId);
    
    // 测试过滤
    app.setFilter('all');
    assertEqual(app.getFilteredTodos().length, 2, '全部过滤应该显示所有待办事项');
    
    app.setFilter('active');
    assertEqual(app.getFilteredTodos().length, 1, '未完成过滤应该只显示未完成的待办事项');
    
    app.setFilter('completed');
    assertEqual(app.getFilteredTodos().length, 1, '已完成过滤应该只显示已完成的待办事项');
});

runner.test('应该正确转义HTML字符', () => {
    const app = new TodoApp();
    
    const text = '<script>alert("xss")</script>';
    const escaped = app.escapeHtml(text);
    
    assert(!escaped.includes('<script>'), '应该转义HTML标签');
    assert(escaped.includes('&lt;'), '应该包含转义后的字符');
});

// 运行测试
if (typeof window !== 'undefined') {
    // 浏览器环境
    document.addEventListener('DOMContentLoaded', () => {
        const success = runner.run();
        
        // 在页面上显示结果
        const resultDiv = document.createElement('div');
        resultDiv.style.cssText = `
            position: fixed;
            top: 10px;
            right: 10px;
            padding: 15px;
            background-color: ${success ? '#2ecc71' : '#e74c3c'};
            color: white;
            border-radius: 5px;
            font-family: monospace;
            z-index: 1000;
        `;
        resultDiv.textContent = success ? '✓ 所有测试通过' : '✗ 有测试失败';
        document.body.appendChild(resultDiv);
        
        // 3秒后自动消失
        setTimeout(() => {
            resultDiv.remove();
        }, 3000);
    });
} else {
    // Node.js环境
    runner.run();
}