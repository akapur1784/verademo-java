pipeline {
    agent any

    
    stages {
        stage('Build') {
            steps {
                sh 'export MAVEN_HOME=/usr/local/Cellar/maven/3.6.3/libexec'
                sh 'mvn --version'
                sh '/usr/local/Cellar/maven/3.6.3/libexec/mvn clean package'
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
