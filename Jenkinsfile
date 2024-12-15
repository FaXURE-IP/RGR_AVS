pipeline {
    agent any
    environment {
        GIT_REPO = 'https://github.com/FaXURE-IP/RGR_AVS.git'
        BRANCH_NAME = 'main' // Убедитесь, что указана правильная ветка
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонируем репозиторий и проверяем нужную ветку
                checkout scm
            }
        }

        stage('Get Changed Files') {
            steps {
                script {
                    // Получаем список измененных файлов в последнем коммите
                    def changes = sh(script: "git diff --name-only HEAD~1 HEAD", returnStdout: true).trim()

                    if (changes) {
                        echo "Changed files: ${changes}"

                        // Выводим содержимое каждого измененного файла
                        changes.split("\n").each { file ->
                            echo "Contents of ${file}:"
                            // Проверяем, существует ли файл, прежде чем выводить его содержимое
                            if (fileExists(file)) {
                                // Используем sh для выполнения команды cat и вывода содержимого файла
                                sh(script: "cat ${file}")
                            } else {
                                echo "File ${file} not found in the repository."
                            }
                        }
                    } else {
                        echo "No changes detected in the last commit."
                    }
                }
            }
        }

        stage('Build C Application') {
            steps {
                script {
                    // Проверяем наличие файла /app/main.c
                    if (fileExists('app/main.c')) {
                        echo 'Building C application...'
                        // Команда для компиляции приложения на C
                        sh 'apt-get update'
                        sh 'apt-get install -y gcc'
                        sh 'gcc app/main.c -o app/main'
                    } else {
                        echo 'C source file not found in /app/main.c'
                    }
                }
            }
        }

        stage('Run C Application') {
            steps {
                script {
                    // Запуск собранного приложения
                    if (fileExists('app/main')) {
                        echo 'Running the C application...'
                        sh './app/main'
                    } else {
                        echo 'Build failed or the executable does not exist.'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution finished.'
        }
    }
}
