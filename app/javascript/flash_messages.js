document.addEventListener('turbo:load', () => {
  const flashMessages = document.querySelectorAll('.flash-message')
  flashMessages.forEach(message => {
    setTimeout(() => {
      message.remove()
    }, 5000)
  })
})