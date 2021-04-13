pipeline {
    agent any
    tools {
      
      maven 'Maven 3.3.9'
      jdk 'jdk8' 
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn --version'
                sh 'mvn clean package'
            }
        }
        stage('Security Scan Master Branch') {
            when {
                branch 'master'
            }
            steps {
                parallel(
                    a:{
                        // Policy scan
                        withCredentials([usernamePassword(credentialsId: 'VeracodeAPI', passwordVariable: 'VERACODEKEY', usernameVariable: 'VERACODEID')]) {
                            veracode applicationName: "Verademo-java", criticality: 'VeryHigh',
                            fileNamePattern: '', replacementPattern: '', scanExcludesPattern: '', scanIncludesPattern: '',
                            scanName: 'build $buildnumber - Jenkins',
                            uploadExcludesPattern: '', uploadIncludesPattern: 'target/*.war', waitForScan: true,
                            vid: VERACODEID, vkey: VERACODEKEY
                        }
                    },
                    b:{
                        // 3rd party scan application
                        withCredentials([string(credentialsId: 'SRCCLR_API_TOKEN', variable: 'SRCCLR_API_TOKEN')]) {
                            sh 'curl -sSL https://download.sourceclear.com/ci.sh | sh'
                        }
                    }
                    
                )
            }
        }
        
        
    }
}
