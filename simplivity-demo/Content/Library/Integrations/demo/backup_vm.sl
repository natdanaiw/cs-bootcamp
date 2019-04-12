namespace: Integrations.demo
flow:
  name: backup_vm
  inputs:
    - vm_name: TestVM
    - backup_name: TestBackup
  workflow:
    - get_vmid:
        do:
          Integrations.demo.get_vmid:
            - vm_name: '${vm_name}'
        publish:
          - vmid
        navigate:
          - FAILURE: on_failure
          - SUCCESS: call_api
    - call_api:
        do:
          Integrations.demo.util.call_api:
            - api_name: "${'/api/virtual_machines/' + vmid + '/backup'}"
            - api_param: "${'{ \"backup_name\": \"' + backup_name + '\" }'}"
        publish:
          - result
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_vmid:
        x: 139
        y: 173
      call_api:
        x: 319
        y: 169
        navigate:
          db661d4c-efbd-72a8-3c9d-1dac4fc8b59e:
            targetId: 3f453593-9d9c-0ca9-d2fc-12f4bcf87d58
            port: SUCCESS
    results:
      SUCCESS:
        3f453593-9d9c-0ca9-d2fc-12f4bcf87d58:
          x: 509
          y: 97
