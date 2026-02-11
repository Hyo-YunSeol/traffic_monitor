# traffic_monitor
### python 코드

```python
start=input("start 입력하면 시작:")

if start == "start":
    mode = int(input('mode를 선택하세요.\n 1: normal mode \n 2: monitor mode\n'))

    cycle = 0
    full_cycle = 0

    if mode == 1:
        print('nomal mode')
        full_cycle = 68

    elif mode == 2:
        print('monitor mode')
        cycle= int(input('cycle number:'))
        full_cycle = 1

    for i in range (full_cycle):
        if mode == 1:
            cycle = i + 1

        while cycle > 68:
            cycle = cycle % 68

        if 1 <= cycle <= 14:
            car_clrstate1 = "green"
            human_clrstate1 = "red"
            car_clrstate2 = "red"
            human_clrstate2 = "green"

        elif 15 <= cycle <= 20:
            car_clrstate1 = "green"
            human_clrstate1 = "red"
            car_clrstate2 = "red"
            human_clrstate2 = "blink"

        elif 21 <= cycle <=22:
            car_clrstate1 = "yellow"
            human_clrstate1 = "red"
            car_clrstate2 = "red"
            human_clrstate2 = "red"

        elif 23 <= cycle <= 32:
            car_clrstate1 = "left"
            human_clrstate1 = "red"
            car_clrstate2 = "red"
            human_clrstate2 = "red"   

        elif 33 <= cycle <= 34:
            car_clrstate1 = "yellow"
            human_clrstate1 = "red"
            car_clrstate2 = "red"
            human_clrstate2 = "red"
    
        elif 35 <= cycle <=48:
            car_clrstate1 = "red"
            human_clrstate1 = "green"
            car_clrstate2 = "green"
            human_clrstate2 = "red"

        elif 49 <= cycle <= 54:
            car_clrstate1 = "red"
            human_clrstate1 = "blink"
            car_clrstate2 = "green"
            human_clrstate2 = "red"

        elif 55 <= cycle <= 56:
            car_clrstate1 = "red"
            human_clrstate1 = "red"
            car_clrstate2 = "yellow"
            human_clrstate2 = "red"

        elif 57 <= cycle <= 66:
            car_clrstate1 = "red"
            human_clrstate1 = "red"
            car_clrstate2 = "left"
            human_clrstate2 = "red"
    
        elif 67 <= cycle <= 68:
            car_clrstate1 = "red"
            human_clrstate1 = "red"
            car_clrstate2 = "yellow"
            human_clrstate2 = "red" 

        if mode == 1:
            print(cycle,"cycle: ")
            print("  NORTH: [car: ",car_clrstate1,"],   [human: ",human_clrstate1,"]")
            print("  WEST:  [car: ",car_clrstate2,"],   [human: ",human_clrstate2,"]")
            print("  SOUTH: [car: ",car_clrstate1,"],   [human: ",human_clrstate1,"]")
            print("  EAST:  [car: ",car_clrstate2,"],   [human: ",human_clrstate2,"]\n")

        
        elif mode == 2:
            if cycle == cycle:
                print(cycle,"cycle: ")
                print("  NORTH: [car: ",car_clrstate1,"],   [human: ",human_clrstate1,"]")
                print("  WEST:  [car: ",car_clrstate2,"],   [human: ",human_clrstate2,"]")
                print("  SOUTH: [car: ",car_clrstate1,"],   [human: ",human_clrstate1,"]")
                print("  EAST:  [car: ",car_clrstate2,"],   [human: ",human_clrstate2,"]\n")
```
