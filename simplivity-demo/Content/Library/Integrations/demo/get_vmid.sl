namespace: Integrations.demo
flow:
  name: get_vmid
  inputs:
    - vm_name: Windows_Server_02
  workflow:
    - call_api:
        do:
          Integrations.demo.util.call_api:
            - api_method: GET
        publish:
          - result
        navigate:
          - FAILURE: on_failure
          - SUCCESS: json_path_query
    - json_path_query:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${result}'
            - json_path: "${\"$.virtual_machines[?(@.name=='\" + vm_name + \"')].id\"}"
        publish:
          - return_result
        navigate:
          - SUCCESS: search_and_replace
          - FAILURE: on_failure
    - search_and_replace:
        do:
          io.cloudslang.base.strings.search_and_replace:
            - origin_string: '${return_result}'
            - text_to_replace: '["'
            - replace_with: ''
        publish:
          - replaced_string
        navigate:
          - SUCCESS: search_and_replace_1
          - FAILURE: on_failure
    - search_and_replace_1:
        do:
          io.cloudslang.base.strings.search_and_replace:
            - origin_string: '${replaced_string}'
            - text_to_replace: '"]'
            - replace_with: ''
        publish:
          - result_id: '${replaced_string}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - vmid: '${result_id}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      call_api:
        x: 137
        y: 135
      json_path_query:
        x: 324
        y: 135
      search_and_replace:
        x: 480
        y: 156
      search_and_replace_1:
        x: 644
        y: 121
        navigate:
          b412e160-33c6-d760-9a51-7f433badfe8d:
            targetId: c99e6b0e-8709-1e60-e2e8-b1405d3de875
            port: SUCCESS
    results:
      SUCCESS:
        c99e6b0e-8709-1e60-e2e8-b1405d3de875:
          x: 638
          y: 316
