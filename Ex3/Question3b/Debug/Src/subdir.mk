################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/3b_assembly.s \
../Src/3b_definitions.s \
../Src/3b_info.s \
../Src/3b_receive.s 

OBJS += \
./Src/3b_assembly.o \
./Src/3b_definitions.o \
./Src/3b_info.o \
./Src/3b_receive.o 

S_DEPS += \
./Src/3b_assembly.d \
./Src/3b_definitions.d \
./Src/3b_info.d \
./Src/3b_receive.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/3b_assembly.d ./Src/3b_assembly.o ./Src/3b_definitions.d ./Src/3b_definitions.o ./Src/3b_info.d ./Src/3b_info.o ./Src/3b_receive.d ./Src/3b_receive.o

.PHONY: clean-Src

