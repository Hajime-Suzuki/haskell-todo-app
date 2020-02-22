import { FormikProps } from 'formik'

export const getError = <TForm extends Record<string, string>>(
  name: keyof TForm,
  errors: FormikProps<TForm>['errors'],
) => {
  if (errors[name]) return { help: errors[name], validateStatus: 'error' as const }
}
