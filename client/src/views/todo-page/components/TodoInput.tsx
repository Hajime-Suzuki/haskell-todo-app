import { Button, Col, Input, Row } from 'antd'
import { Formik } from 'formik'
import React from 'react'
import { todoApi } from '../../../domain/todo/api'

export const TodoInput = () => {
  return (
    <>
      <Formik initialValues={{ title: '' }} onSubmit={todoApi.saveTodo}>
        {f => {
          return (
            <>
              <Row gutter={[0, 16]}>
                <Col>
                  <Input value={f.values.title} name="title" onChange={f.handleChange}></Input>
                </Col>
                <Col>
                  <Button type="primary" onClick={f.handleSubmit as any}>
                    submit
                  </Button>
                </Col>
              </Row>
            </>
          )
        }}
      </Formik>
    </>
  )
}
