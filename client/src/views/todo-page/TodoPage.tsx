import React, { useEffect, useState } from 'react'
import { TodoInput } from './components/TodoInput'
import { Layout, Row, Col, Typography, Spin } from 'antd'
import { formConfig } from './form-config'
import { TodoList } from './components/TodoList'
import { todoApi } from '../../utils/api/todo-api'
import { Todo } from '../../domain/todo/todo'

const { Title } = Typography
const { Content } = Layout

const useTodoPageData = () => {
  const [todos, setTodos] = useState<Todo[] | null>(null)

  const getTodos = async () => {
    const { todos } = await todoApi.getTodos()
    setTodos(todos)
  }

  const addTodo = async (todo: Todo) => {
    setTodos([...(todos || []), todo])
  }

  const deleteTodo = async (todoIndex: number) => {
    const id = todos?.[todoIndex]?.id
    if (!id) return

    await todoApi.deleteTodo(id)
    setTodos(todos?.filter(todo => todo.id !== id) || null)
  }

  const toggleDone = async (todo: Todo, done: boolean) => {
    const targetIndex = todos?.findIndex(v => v.id === todo.id) ?? -1
    const updated = [...(todos || [])]
    updated[targetIndex].done = done

    await todoApi.toggleDone(updated[targetIndex].id, done)
    setTodos(updated)
  }

  const toggleDoneAll = async (done: boolean) => {
    if (!todos) return
    const target = todos.filter(t => t.done !== done)
    await Promise.all(target.map(t => todoApi.toggleDone(t.id, done)))
    setTodos(todos.map(t => ({ ...t, done })))
  }

  const deleteCompleted = async () => {
    if (!todos) return
    const completedTodoIds = todos?.filter(({ done }) => done)
    await Promise.all(completedTodoIds.map(({ id }) => todoApi.deleteTodo(id)))
    setTodos(todos.filter(({ done }) => !done))
  }

  useEffect(() => {
    getTodos()
  }, [])

  return { todos, addTodo, deleteTodo, toggleDone, toggleDoneAll, deleteCompleted }
}

export const TodoPage = () => {
  const { todos, addTodo, deleteTodo, toggleDone, toggleDoneAll, deleteCompleted } = useTodoPageData()
  if (!todos) return <Spin size="large" />

  return (
    <Content style={{ minHeight: '100vh', padding: 50, textAlign: 'center' }}>
      <Row type="flex" justify="center" gutter={[16, 24]}>
        <Col xs={24}>
          <div style={{ maxWidth: 500, margin: 'auto' }}>
            <Title level={2}>Todo list</Title>
            <TodoInput config={formConfig({ onComplete: addTodo, onSubmit: todoApi.saveTodo })} />
          </div>
        </Col>
        <Col xs={24}>
          <TodoList
            todos={todos}
            deleteTodo={deleteTodo}
            toggleDone={toggleDone}
            toggleDoneAll={toggleDoneAll}
            deleteCompleted={deleteCompleted}
          />
        </Col>
      </Row>
    </Content>
  )
}
