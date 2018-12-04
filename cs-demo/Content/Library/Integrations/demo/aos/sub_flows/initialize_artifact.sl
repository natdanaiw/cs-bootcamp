namespace: Integrations.demo.aos.sub_flows
flow:
  name: initialize_artifact
  inputs:
    - host: 10.0.46.38
    - username: root
    - password: admin@123
    - artifact_url:
        required: false
    - script_url: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/deploy_war.sh'
    - parameters:
        required: false
  workflow:
    - is_artifact_given:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${artifact_url}'
            - second_string: ''
        navigate:
          - SUCCESS: copy_script
          - FAILURE: copy_artifact
    - copy_artifact:
        do:
          Integrations.demo.aos.sub_flows.remote_copy:
            - host: '${host}'
            - username: '${username}'
            - password: '${password}'
            - url: '${artifact_url}'
        publish:
          - artifact_name: '${filename}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: copy_script
    - copy_script:
        do:
          Integrations.demo.aos.sub_flows.remote_copy:
            - host: '${host}'
            - username: '${username}'
            - password: '${password}'
            - url: '${script_url}'
        publish:
          - script_name: '${filename}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: execute_script
    - execute_script:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && chmod 755 '+script_name+' && sh '+script_name+' '+get('artifact_name', '')+' '+get('parameters', '')+' > '+script_name+'.log'}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish:
          - command_return_code
        navigate:
          - SUCCESS: delete_script
          - FAILURE: delete_script
    - delete_script:
        do:
          Integrations.demo.aos.tools.delete_file:
            - host: '${host}'
            - username: '${username}'
            - password: '${password}'
            - filename: '${script_name}'
        publish: []
        navigate:
          - SUCCESS: is_true
          - FAILURE: on_failure
    - is_true:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: "${str(command_return_code == '0')}"
        navigate:
          - 'TRUE': SUCCESS
          - 'FALSE': FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      copy_script:
        x: 481
        y: 226
      copy_artifact:
        x: 214
        y: 219
      is_artifact_given:
        x: 395
        y: 70
      execute_script:
        x: 102
        y: 385
      delete_script:
        x: 318
        y: 401
      is_true:
        x: 520
        y: 394
        navigate:
          331a0a1a-7ccb-fb54-7ebb-08cccd9f9c8d:
            targetId: f3836eac-d579-20de-99b8-479edcb1df84
            port: 'TRUE'
          d085f36b-0e85-6bae-9a09-7c3dca651b53:
            targetId: eab7681e-2f60-b116-a5a8-e04f55b81cb3
            port: 'FALSE'
    results:
      SUCCESS:
        f3836eac-d579-20de-99b8-479edcb1df84:
          x: 659
          y: 335
      FAILURE:
        eab7681e-2f60-b116-a5a8-e04f55b81cb3:
          x: 656
          y: 454
