pipeline {
    agent any
    
    tools {
        jdk 'JDK-17'
    }
    
    environment {
        SONAR_HOST_URL = 'http://localhost:9000'
        SONAR_PROJECT_KEY = 'airbnb-booking-app'
        SONAR_PROJECT_NAME = 'Airbnb Booking Application'
        SONAR_TOKEN = 'sqp_2a96ccebdce00d2859e5255c8bf9ff70a60716f6'
    }
    
    stages {
        stage('Configure Git') {
            steps {
                bat '''
                    git config --global http.postBuffer 524288000
                    git config --global core.compression 0
                '''
            }
        }
        
        stage('Checkout') {
            steps {
                retry(3) {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/master']],
                        extensions: [
                            [$class: 'CloneOption', depth: 0, noTags: false, shallow: false, timeout: 30]
                        ],
                        userRemoteConfigs: [[url: 'https://github.com/msfayoub/Airbnb.git']]
                    ])
                }
            }
        }
        
        stage('Compile') {
            steps {
                echo 'Compiling Java source files...'
                bat '''
                    if not exist "build\\classes" mkdir build\\classes
                    javac -encoding ISO-8859-1 -d build/classes -cp "lib/*" -sourcepath src src/controller/*.java src/dao/*.java src/model/*.java src/function/*.java
                '''
            }
        }
        
        stage('Compile Tests') {
            steps {
                echo 'Compiling test files...'
                bat '''
                    if not exist "build\\test-classes" mkdir build\\test-classes
                    javac -encoding ISO-8859-1 -d build/test-classes -cp "lib/*;build/classes" -sourcepath test test/dao/*.java test/function/*.java test/model/*.java
                '''
            }
        }
        
        stage('Run Tests') {
            steps {
                echo 'Running JUnit tests...'
                bat '''
                    if not exist "test-results" mkdir test-results
                    
                    java -cp "lib/*;build/classes;build/test-classes" ^
                    org.junit.platform.console.ConsoleLauncher ^
                    --scan-classpath ^
                    --reports-dir=test-results ^
                    --disable-banner
                '''
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'test-results/*.xml'
                }
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'SonarScanner'
                    withSonarQubeEnv('SonarQube') {
                        bat """
                            "${scannerHome}\\bin\\sonar-scanner.bat" ^
                            -Dsonar.projectKey=${SONAR_PROJECT_KEY} ^
                            -Dsonar.projectName="${SONAR_PROJECT_NAME}" ^
                            -Dsonar.sources=src ^
                            -Dsonar.tests=test ^
                            -Dsonar.java.binaries=build/classes ^
                            -Dsonar.java.test.binaries=build/test-classes ^
                            -Dsonar.sourceEncoding=ISO-8859-1 ^
                            -Dsonar.java.libraries=lib/*.jar ^
                            -Dsonar.junit.reportPaths=test-results
                        """
                    }
                    echo 'SonarQube analysis completed! View results at: http://localhost:9000/dashboard?id=airbnb-booking-app'
                }
            }
        }
        
        stage('Package WAR') {
            steps {
                echo 'Creating WAR file...'
                bat '''
                    if not exist "dist" mkdir dist

                    xcopy /E /I /Y WebContent dist\\Airbnb

                    if not exist "dist\\Airbnb\\WEB-INF\\classes" mkdir dist\\Airbnb\\WEB-INF\\classes
                    xcopy /E /I /Y build\\classes dist\\Airbnb\\WEB-INF\\classes

                    xcopy /E /I /Y src\\META-INF dist\\Airbnb\\WEB-INF\\classes\\META-INF

                    cd dist
                    "%JAVA_HOME%\\bin\\jar" -cvf airbnb.war -C Airbnb .
                '''
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'dist/airbnb.war', fingerprint: true
                echo 'WAR file archived successfully!'
            }
        }
    }
    
    post {
        success {
            echo '========================================='
            echo '✓ Pipeline completed successfully!'
            echo '========================================='
            echo 'Test Results: Check Jenkins test report'
            echo 'Artifacts:'
            echo '  - WAR file: Check Jenkins artifacts'
            echo '  - SonarQube: http://localhost:9000/dashboard?id=airbnb-booking-app'
            echo '========================================='
        }
        failure {
            echo '✗ Pipeline failed!'
        }
        always {
            script {
                if (fileExists('test-results')) {
                    junit allowEmptyResults: true, testResults: 'test-results/*.xml'
                }
            }
            cleanWs()
        }
    }
}
