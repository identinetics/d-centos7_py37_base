pipeline {
    agent any
    parameters {
        string(defaultValue: 'True', description: '"True": "Set --nocache for docker build; otherwise leave empty', name: 'nocache')
        string(defaultValue: '', description: '"True": push docker image after build; otherwise leave empty', name: 'pushimage')
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                    if [[ "$nocache" ]]; then
                         nocacheopt='--no-cache'
                         echo 'build with option nocache'
                    fi
                    docker build $nocacheopt -t intra/centos7_py36_base .
                '''
            }
        }
       stage('Push ') {
            when {
                expression { params.pushimage?.trim() != '' }
            }
            steps {
                sh '''
                    if [[ "$DOCKER_REGISTRY_USER" ]]; then
                        echo "Docker registry user: $DOCKER_REGISTRY_USER"   # defined in Jenkins env
                        docker tag intra/centos7_py36_base $DOCKER_REGISTRY_USER/centos7_py36_base
                        docker push $DOCKER_REGISTRY_USER/centos7_py36_base
                    else
                        echo 'DOCKER_REGISTRY_USER not defined - cannot push image'
                    fi
                '''
            }
        }
    }
}
