import { FormikConfig } from 'formik'
import { todoApi } from '../../domain/todo/api'
import { string, object } from 'yup'

export const formConfig: FormikConfig<{ title: string }> = {
  initialValues: { title: '' },
  onSubmit: async (values, { resetForm }) => {
    await todoApi.saveTodo(values)
    resetForm()
  },
  validateOnChange: false,
  validateOnBlur: true,
  validationSchema: object().shape({
    title: string()
      .required()
      .min(2, 'name must be equal to or longer than 2 characters')
      .max(20, 'name must be shorter than 20 characters'),
  }),
}

