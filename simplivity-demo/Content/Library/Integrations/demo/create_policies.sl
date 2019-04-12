namespace: Integrations.demo
flow:
  name: create_policies
  inputs:
    - policies_name: Test Policy
  workflow:
    - call_api:
        do:
          Integrations.demo.util.call_api:
            - api_name: /api/policies
            - api_param: "${'{ \"name\": \"'+ policies_name +'\"}'}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      call_api:
        x: 149
        y: 142
        navigate:
          a3902b80-0890-ba3f-282f-2a176a1a9c12:
            targetId: 8363a8a8-9865-7bf6-19cb-75a92b52dd60
            port: SUCCESS
    results:
      SUCCESS:
        8363a8a8-9865-7bf6-19cb-75a92b52dd60:
          x: 485
          y: 128
