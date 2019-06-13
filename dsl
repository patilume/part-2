BASE_STEPS = '''#!/bin/bash
mkdir -p ~/.foremast
aws s3 sync s3://example-bucket/ . --exclude "*" --include "foremast.cfg"
virtualenv -p python3 venv
. venv/bin/activate
pip install -U --quiet foremast==3.10.1
'''
APP_STEPS = BASE_STEPS + '''
prepare-app-pipeline
'''

def emailTrigger = {
    trigger {
        email {
            recipientList '$PROJECT_DEFAULT_RECIPIENTS'
            subject '$PROJECT_DEFAULT_SUBJECT'
            body '$PROJECT_DEFAULT_CONTENT'
            sendToDevelopers true
            sendToRequester false
            includeCulprits false
            sendToRecipientList true
        }
    }
}
job("foremast-pipeline-prepare") {
  parameters {
    stringParam('APP', '', 'Application name')
    stringParam('EMAIL', 'admin@example.com', 'Associated email')
    stringParam('PROJECT', 'None', 'Git project associated with application')
    stringParam('GIT_REPO', 'None', 'The repository name to associate with application')
  }
configure { project ->
    project / publishers << 'hudson.plugins.emailext.ExtendedEmailPublisher' {
              recipientList 'Engineering@company.com'
              configuredTriggers {
                  'hudson.plugins.emailext.plugins.trigger.FailureTrigger' emailTrigger
                  'hudson.plugins.emailext.plugins.trigger.FixedTrigger' emailTrigger
              }
              contentType 'default'
              defaultSubject '$DEFAULT_SUBJECT'
              defaultContent '$DEFAULT_CONTENT'
}
}
  
  

logRotator {
    numToKeep(2)
    artifactNumToKeep(2)
  }
scm {
    git {
      remote {
        url("git@git.example.com:spinnaker/foremast-templates.git")
        credentials('-none-')
      }
      extensions {
        relativeTargetDirectory('foremast-templates')
        }
      branch('*/master')
    }
  }
  
label('master')
steps {
    shell(APP_STEPS)
  }
  
wrappers {
    colorizeOutput()
  }
}

if (jenkins.model.Jenkins.instance.getItemByFullName('foremast-pipeline-prepare')) {
    queue('quidryan-aws-sdk-test-feature1')
}
