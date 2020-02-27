import { Button, Col, Form, Input, Row } from 'antd'
import { Form as FormikForm, Formik, FormikConfig } from 'formik'
import React, { FC } from 'react'
import { getError } from '../../../utils/forms/get-error'
import { AddTodoFormValues } from '../form-config'

const FormItem = Form.Item

type Props = {
  config: FormikConfig<AddTodoFormValues>
}

export const TodoInput: FC<Props> = ({ config }) => {
  return (
    <Formik {...config}>
      {f => {
        return (
          <FormikForm>
            <Row gutter={[0, 0]}>
              <Col>
                <FormItem {...getError('title', f.errors)}>
                  <Input placeholder="title" value={f.values.title} name="title" onChange={f.handleChange} />
                </FormItem>
              </Col>
              <Col>
                <Button htmlType="submit" type="primary">
                  add
                </Button>
              </Col>
            </Row>
          </FormikForm>
        )
      }}
    </Formik>
  )
}
