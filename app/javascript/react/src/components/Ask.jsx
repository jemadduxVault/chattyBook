import React, { useState } from 'react'

const Ask = () => {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const [question, setQuestion] = useState('');
  const handleChangeOfQuestion = (event) => {
    setQuestion(event.target.value)
  }
  const [response, setResponse] = useState('');
  const askQuestion = async () => {
    try {
      const response = await fetch('/questions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({question: question})
      });
      const data = await response.json();
      setResponse(data.message)
    } catch (error) {
      console.error(error);
    }
  }
  return (
    <div className="centered-container">
      <div className="centered-content">
        <h1>Talk to Frankenstein!!!</h1>
        <h6>(The book)</h6>
        <p>Question:</p>
        <textarea
          rows={6}
          cols={50}
          value={question}
          onChange={handleChangeOfQuestion}
        />
        <br/>
        <button onClick={askQuestion}>Ask</button>
        <br/>
        <p>Answer:</p>
        <textarea
          rows={6}
          cols={50}
          value={response}
        />
      </div>
    </div>
  )
}
export default Ask;