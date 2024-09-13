"use client"

import { FormProps } from "@/app/types/forms";
import { ErrorMessage, Field, Form, Formik } from "formik";
import { validationSchema } from "./data/form.data";

export default function PostalCodeForm({
  onChange
}: FormProps) {
  return (
    <Formik
      initialValues={{ postCode: '' }}
      validationSchema={validationSchema}
      onSubmit={async values => { }}
    >
      {({ handleChange }) => (
        <Form>
          <div className="input-container">
            <label htmlFor="postalCode">Postal Code</label>
            <Field name="postalCode" type="number" placeholder="12345" onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
              handleChange(e);
              onChange({
                [e.target.name]: e.target.value
              })
            }} />
            <div className="error-container">
              <ErrorMessage name="postalCode" component="div" />
            </div>
          </div>
        </Form>
      )}
    </Formik>
  )
}