@Library('tests') _
  
node {
	try {
   
   stage ('clone') {
        	s001_ci_Checkout ()
        }
		}
	
	 
		

catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
	
}
