################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/assembly.s \
../Src/count_character.s \
../Src/create_led_pattern.s \
../Src/decode.s \
../Src/definitions.s \
../Src/delay.s \
../Src/initialise.s \
../Src/letter_counter.s 

OBJS += \
./Src/assembly.o \
./Src/count_character.o \
./Src/create_led_pattern.o \
./Src/decode.o \
./Src/definitions.o \
./Src/delay.o \
./Src/initialise.o \
./Src/letter_counter.o 

S_DEPS += \
./Src/assembly.d \
./Src/count_character.d \
./Src/create_led_pattern.d \
./Src/decode.d \
./Src/definitions.d \
./Src/delay.d \
./Src/initialise.d \
./Src/letter_counter.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/assembly.d ./Src/assembly.o ./Src/count_character.d ./Src/count_character.o ./Src/create_led_pattern.d ./Src/create_led_pattern.o ./Src/decode.d ./Src/decode.o ./Src/definitions.d ./Src/definitions.o ./Src/delay.d ./Src/delay.o ./Src/initialise.d ./Src/initialise.o ./Src/letter_counter.d ./Src/letter_counter.o

.PHONY: clean-Src

