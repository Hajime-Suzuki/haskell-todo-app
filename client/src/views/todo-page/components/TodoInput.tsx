import { Button, Col, Form, Input, Row } from 'antd'
import { Form as FormikForm, Formik, FormikConfig } from 'formik'
import React, { FC } from 'react'
import { getError } from '../../../utils/forms/get-error'

const FormItem = Form.Item

type FormValues = {
  title: string
}
type Props = {
  config: FormikConfig<FormValues>
}

export const TodoInput: FC<Props> = ({ config }) => {
  return (
    <Formik {...config}>
      {f => {
        return (
          <FormikForm>
            <Row gutter={[0, 8]}>
              <Col>
                <FormItem {...getError('title', f.errors)}>
                  <Input value={f.values.title} name="title" onChange={f.handleChange}></Input>
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
