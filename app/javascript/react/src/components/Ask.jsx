import React, { useState } from 'react'

const Ask = () => {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const [response, setResponse] = useState('');
  const question = async () => {
    try {
      const response = await fetch('/questions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({question: "what is the book name?"})
      });
      const data = await response.json();
      setResponse(data.message)
    } catch (error) {
      console.error(error);
    }
  }
  return (
    <div>
      <button onClick={question}>Ask</button>
      <span>---{response}---</span>
    </div>
  )
}
export default Ask;