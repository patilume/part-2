@Library('tests') _
  
node {
	try {
   
   stage ('clone') {
        	Checkout ()
        }
		}
	
	 
		

catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
	
}
