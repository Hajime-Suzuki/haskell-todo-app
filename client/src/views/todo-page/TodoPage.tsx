import React, { useEffect, useState } from 'react'
import { TodoInput } from './components/TodoInput'
import { Layout, Row, Col, Typography } from 'antd'
import { formConfig } from './form-config'
import { TodoList } from './components/TodoList'
import { todoApi } from '../../domain/todo/api'
import { Todo } from '../../domain/todo/todo'

const { Title } = Typography
const { Content } = Layout

const useTodoPageData = () => {
  const [todos, setTodos] = useState()

  const getTodos = async () => {
    const { todos } = await todoApi.getTodos()
    setTodos(todos)
  }

  const addTodo = async (todo: Todo) => {
    setTodos([...todos, todo])
  }

  useEffect(() => {
    getTodos()
  }, [])

  return { todos, addTodo }
}

export const TodoPage = () => {
  const { todos, addTodo } = useTodoPageData()

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
          <TodoList todos={todos} />
        </Col>
      </Row>
    </Content>
  )
}
