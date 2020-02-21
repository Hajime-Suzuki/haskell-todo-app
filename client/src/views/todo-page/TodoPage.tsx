import React from 'react'
import { TodoInput } from './components/TodoInput'
import { Layout, Row, Col } from 'antd'
const { Content } = Layout

export const TodoPage = () => {
  return (
    <Layout>
      <Content>
        <Row type="flex" justify="center">
          <Col xs={24} md={12} lg={12} xl={12} style={{ maxWidth: 800, minHeight: '100vh' }}>
            <TodoInput></TodoInput>
          </Col>
        </Row>
      </Content>
    </Layout>
  )
}
