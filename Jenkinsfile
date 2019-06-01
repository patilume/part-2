@Library('tests') _
  
node {
	try {
   
   stage ('clone') {
        	Checkout ()
        }
		stage ('Build') {
		sh '/opt/maven/bin/mvn clean install -Dskiptest'
			//buildmaven ()
		}
	
	}
	

		

catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
	
}
