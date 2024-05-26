// 所有脚本命令包含在pipeline{}中
pipeline {  
	// 指定任务在哪个节点执行（Jenkins支持分布式）
    agent any
    
    // 配置全局环境，指定变量名=变量值信息
    environment{
    	host = '192.168.11.11'
    }

    // 存放所有任务的合集
    stages {
    	// 单个任务
        stage('任务1') {
        	// 实现任务的具体流程
            steps {
                echo 'do something'
            }
        }
		// 单个任务
        stage('任务2') {
        	// 实现任务的具体流程
            steps {
                echo 'do something'
            }
        }
        // ……
    }
}
