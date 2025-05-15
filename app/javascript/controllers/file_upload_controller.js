import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "dropZone",
    "input",
    "defaultIcon",
    "preview",
    "imagePreview",
    "videoPreview",
    "fileIcon",
    "fileName",
    "fileSize",
    "placeholder",
    "error",
    "submit"
  ]

  connect() {
    this.dragCounter = 0
  }

  handleSubmit(event) {
    if (event.detail.success) {
      window.location.reload()
    }
  }

  dragOver(event) {
    event.preventDefault()
    if (this.dragCounter === 0) {
      this.dropZoneTarget.classList.add('bg-lime-50', 'border-lime-300')
    }
    this.dragCounter++
  }

  dragLeave(event) {
    event.preventDefault()
    this.dragCounter--
    if (this.dragCounter === 0) {
      this.dropZoneTarget.classList.remove('bg-lime-50', 'border-lime-300')
    }
  }

  drop(event) {
    event.preventDefault()
    this.dragCounter = 0
    this.dropZoneTarget.classList.remove('bg-lime-50', 'border-lime-300')
    
    const files = event.dataTransfer.files
    if (files.length > 0) {
      this.inputTarget.files = files
      this.handleFiles()
    }
  }

  handleFiles() {
    const file = this.inputTarget.files[0]
    if (!file) return

    // Очищаем предыдущие ошибки
    this.errorTarget.classList.add('hidden')
    this.errorTarget.querySelector('p').textContent = ''

    // Проверяем тип файла
    if (!this.isValidFileType(file)) {
      this.showError('Неподдерживаемый тип файла. Пожалуйста, загрузите изображение или видео.')
      this.inputTarget.value = ''
      return
    }

    // Показываем превью
    this.showFilePreview(file)
    
    // Активируем кнопку отправки
    this.submitTarget.disabled = false
  }

  showFilePreview(file) {
    // Скрываем плейсхолдер и показываем превью
    this.placeholderTarget.classList.add('hidden')
    this.defaultIconTarget.classList.add('hidden')
    this.previewTarget.classList.remove('hidden')

    // Показываем имя файла и размер
    this.fileNameTarget.textContent = file.name
    this.fileSizeTarget.textContent = this.formatFileSize(file.size)

    // Скрываем все превью
    this.imagePreviewTarget.classList.add('hidden')
    this.videoPreviewTarget.classList.add('hidden')
    this.fileIconTarget.classList.add('hidden')

    if (file.type.startsWith('image/')) {
      this.showImagePreview(file)
    } else if (file.type.startsWith('video/')) {
      this.showVideoPreview(file)
    } else {
      this.fileIconTarget.classList.remove('hidden')
    }
  }

  showImagePreview(file) {
    const reader = new FileReader()
    reader.onload = (e) => {
      this.imagePreviewTarget.src = e.target.result
      this.imagePreviewTarget.classList.remove('hidden')
    }
    reader.readAsDataURL(file)
  }

  showVideoPreview(file) {
    const url = URL.createObjectURL(file)
    this.videoPreviewTarget.querySelector('source').src = url
    this.videoPreviewTarget.load()
    this.videoPreviewTarget.classList.remove('hidden')
  }

  showError(message) {
    this.errorTarget.classList.remove('hidden')
    this.errorTarget.querySelector('p').textContent = message
  }

  isValidFileType(file) {
    return file.type.startsWith('image/') || file.type.startsWith('video/')
  }

  formatFileSize(bytes) {
    if (bytes === 0) return '0 Bytes'
    const k = 1024
    const sizes = ['Bytes', 'KB', 'MB', 'GB']
    const i = Math.floor(Math.log(bytes) / Math.log(k))
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
  }
} 