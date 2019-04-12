namespace: Integrations.demo
flow:
  name: poweron_vm
  inputs:
    - vm_name: TestVM
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
            - api_name: "${'/api/virtual_machines/' + vmid + '/power_on'}"
            - api_param: '{}'
        publish:
          - result
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  outputs:
    - result: '${result}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_vmid:
        x: 136
        y: 185
      call_api:
        x: 326
        y: 189
        navigate:
          65294f64-54e0-dea9-ac86-6be3bf27513b:
            targetId: 63363527-f0ae-29b3-6e77-0a0c72846531
            port: SUCCESS
    results:
      SUCCESS:
        63363527-f0ae-29b3-6e77-0a0c72846531:
          x: 524
          y: 183
