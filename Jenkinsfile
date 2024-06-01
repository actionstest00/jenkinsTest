pipeline {
    agent any
    environment {
        harborHost = 'http://hsz9mxzgnwxhshsh3.neiwangyun.net/api/v2.0'
        harborRepo = 'tasktest_pipeline'
        harborUser = 'admin'
        harborPasswd = 'Harbor12345'
        HARBOR_PROJECT = 'repository'
    }
    parameters {
        choice(name: 'DEPLOY_ACTION', choices: ['Deploy New Version', 'Rollback'], description: 'Choose deploy action')
    }
    stages {
        stage('Initialize') {
            steps {
                script {
                    def tags = getHarborTags()
                    def selectedTag = input(
                        id: 'selectTag', message: 'Select image tag',
                        parameters: [choice(name: 'IMAGE_TAG', choices: tags, description: 'Choose the image tag')]
                    )
                    env.SELECTED_TAG = selectedTag
                }
            }
        }
        stage('拉取Git代码') {
            steps {
                script {
                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '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', url: 'https://github.com/iSmartSV/jenkinsTest.git']]])
                }
            }
        }
        stage('构建代码') {
            steps {
                script {
                    sh '/var/jenkins_home/apache-maven-3.9.6/bin/mvn clean package -DskipTests'
                }
            }
        }
        stage('检测代码质量') {
            steps {
                script {
                    sh '/var/jenkins_home/apache-maven-3.9.6/bin/mvn sonar:sonar -P sonar'
                }
            }
        }
        stage('制作自定义镜像并发布Harbor') {
            steps {
                script {
                    sh '''cp ./target/*.jar ./
                    docker build -t ${JOB_NAME}:${env.SELECTED_TAG} ./'''

                    sh '''docker login -u ${harborUser} -p ${harborPasswd} ${harborHost}
                    docker tag ${JOB_NAME}:${env.SELECTED_TAG} ${harborHost}/${harborRepo}/${JOB_NAME}:${env.SELECTED_TAG}
                    docker push ${harborHost}/${harborRepo}/${JOB_NAME}:${env.SELECTED_TAG}'''
                }
            }
        }
    }
}

def getHarborTags() {
    node {
        def response = sh(script: "curl -u ${env.harborUser}:${env.harborPasswd} ${env.harborHost}/projects/${env.HARBOR_PROJECT}/repositories/${env.harborRepo}/artifacts", returnStdout: true).trim()
        def images = readJSON text: response
        def tags = images.collect { it.tags[0].name }
        return tags
    }
}
