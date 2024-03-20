################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/3eN_Receive_Trans.s \
../Src/3eN_assembly.s \
../Src/3eN_definitions.s \
../Src/3eN_info.s \
../Src/count_character.s \
../Src/create_led_pattern.s \
../Src/definitions.s \
../Src/delay.s \
../Src/get_fucked.s \
../Src/initialise.s 

OBJS += \
./Src/3eN_Receive_Trans.o \
./Src/3eN_assembly.o \
./Src/3eN_definitions.o \
./Src/3eN_info.o \
./Src/count_character.o \
./Src/create_led_pattern.o \
./Src/definitions.o \
./Src/delay.o \
./Src/get_fucked.o \
./Src/initialise.o 

S_DEPS += \
./Src/3eN_Receive_Trans.d \
./Src/3eN_assembly.d \
./Src/3eN_definitions.d \
./Src/3eN_info.d \
./Src/count_character.d \
./Src/create_led_pattern.d \
./Src/definitions.d \
./Src/delay.d \
./Src/get_fucked.d \
./Src/initialise.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/3eN_Receive_Trans.d ./Src/3eN_Receive_Trans.o ./Src/3eN_assembly.d ./Src/3eN_assembly.o ./Src/3eN_definitions.d ./Src/3eN_definitions.o ./Src/3eN_info.d ./Src/3eN_info.o ./Src/count_character.d ./Src/count_character.o ./Src/create_led_pattern.d ./Src/create_led_pattern.o ./Src/definitions.d ./Src/definitions.o ./Src/delay.d ./Src/delay.o ./Src/get_fucked.d ./Src/get_fucked.o ./Src/initialise.d ./Src/initialise.o

.PHONY: clean-Src

