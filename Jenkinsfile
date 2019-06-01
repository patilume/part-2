@Library('tests') _
  
node {
	try {
   
   stage ('clone') {
        	Checkout ()
        }
		stage ('Build') {
		buildmaven ()
		}
	
	}
	

		

catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
	
}
