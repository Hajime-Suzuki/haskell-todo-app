import React from 'react'
import { TodoInput } from './components/TodoInput'
import { Layout, Row, Col, Typography } from 'antd'
import { formConfig } from './form-config'

const { Title } = Typography
const { Content } = Layout

export const TodoPage = () => {
  return (
    <Layout>
      <Content style={{ minHeight: '100vh', padding: 50 }}>
        <Row type="flex" justify="center">
          <Col xs={24}>
            <div style={{ maxWidth: 500, textAlign: 'center', margin: 'auto' }}>
              <Title level={2}>Todo list</Title>
              <TodoInput config={formConfig}></TodoInput>
            </div>
          </Col>
        </Row>
      </Content>
    </Layout>
  )
}
