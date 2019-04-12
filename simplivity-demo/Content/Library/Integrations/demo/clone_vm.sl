namespace: Integrations.demo
flow:
  name: clone_vm
  inputs:
    - source_vm_name: Windows_Server_02
    - vm_name: TestVM
    - power_on:
        default: 'true'
        required: false
  workflow:
    - get_vmid:
        do:
          Integrations.demo.get_vmid:
            - vm_name: '${source_vm_name}'
        publish:
          - vmid
        navigate:
          - FAILURE: on_failure
          - SUCCESS: call_api
    - call_api:
        do:
          Integrations.demo.util.call_api:
            - api_name: "${'/api/virtual_machines/' + vmid + '/clone'}"
            - api_param: "${'{ \"virtual_machine_name\": \"'+ vm_name +'\", \"app_consistent\": false,  \"consistency_type\": \"NONE\" }'}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: sleep
    - poweron_vm:
        do:
          Integrations.demo.poweron_vm:
            - vm_name: '${vm_name}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - is_true:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: '${power_on}'
        navigate:
          - 'TRUE': poweron_vm
          - 'FALSE': SUCCESS
    - sleep:
        do:
          io.cloudslang.base.utils.sleep:
            - seconds: '15'
        navigate:
          - SUCCESS: is_true
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_vmid:
        x: 100
        y: 250
      call_api:
        x: 274
        y: 407
      poweron_vm:
        x: 566
        y: 82
        navigate:
          74af9b0f-69c9-a162-5544-7dc86d6e7e59:
            targetId: 9087fc1c-2d8c-f2ec-f38c-1c72dd215a0d
            port: SUCCESS
      is_true:
        x: 498
        y: 270
        navigate:
          7af0e9a7-f5c3-c072-ab1f-9b9bffb77617:
            targetId: 9087fc1c-2d8c-f2ec-f38c-1c72dd215a0d
            port: 'FALSE'
      sleep:
        x: 344
        y: 137
    results:
      SUCCESS:
        9087fc1c-2d8c-f2ec-f38c-1c72dd215a0d:
          x: 750
          y: 379
