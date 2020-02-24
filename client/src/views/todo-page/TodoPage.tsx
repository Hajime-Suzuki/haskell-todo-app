import React, { useEffect, useState } from 'react'
import { TodoInput } from './components/TodoInput'
import { Layout, Row, Col, Typography, Spin } from 'antd'
import { formConfig } from './form-config'
import { TodoList } from './components/TodoList'
import { todoApi } from '../../domain/todo/api'
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

  useEffect(() => {
    getTodos()
  }, [])

  return { todos, addTodo, deleteTodo }
}

export const TodoPage = () => {
  const { todos, addTodo, deleteTodo } = useTodoPageData()
  if (!todos) return <Spin size="large" />

  return (
    <Content style={{ minHeight: '100vh', padding: 50, textAlign: 'center' }}>
      <Row type="flex" justify="center" gutter={[16, 0]}>
        <Col xs={24}>
          <div style={{ maxWidth: 500, margin: 'auto' }}>
            <Title level={2}>Todo list</Title>
            <TodoInput config={formConfig({ onComplete: addTodo, onSubmit: todoApi.saveTodo })} />
          </div>
        </Col>
        <Col xs={24}>
          <TodoList todos={todos} deleteTodo={deleteTodo} />
        </Col>
      </Row>
    </Content>
  )
}
