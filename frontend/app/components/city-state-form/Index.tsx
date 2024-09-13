"use client"

import { FormProps } from "@/app/types/forms";
import { ErrorMessage, Field, Form, Formik } from "formik";
import { validationSchema } from "./data/form.data";
import styles from "./index.module.css";

export default function CityStateForm({
  onChange
}: FormProps) {
  return (
    <Formik
      initialValues={{ city: '', state: '' }}
      validationSchema={validationSchema}
      onSubmit={async values => {

      }}
    >
      {({ handleChange }) => (
        <Form>
          <div className={styles.inputs}>
            <div className="input-container">
              <label htmlFor="city">City</label>
              <Field name="city" type="text" placeholder="Chicago" onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
                handleChange(e);
                onChange({
                  [e.target.name]: e.target.value
                })
              }} />
              <div className="error-container">
                <ErrorMessage name="city" component="div" />
              </div>
            </div>

            <div className="input-container">
              <label htmlFor="state">State</label>
              <Field name="state" type="text" placeholder="Illinois" onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
                handleChange(e);
                onChange({
                  [e.target.name]: e.target.value
                })
              }} />
              <div className="error-container">
                <ErrorMessage name="state" component="div" />
              </div>
            </div>
          </div>
        </Form>
      )}
    </Formik>
  )
}